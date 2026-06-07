allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
// Fuerza a TODOS los módulos Android (incluidos los plugins, p.ej.
// shared_preferences_android) a usar el NDK y las build-tools ya instaladas,
// en vez de las que piden por defecto (28.2.x / 36.0.0) y que no están
// instaladas (su descarga automática falla por permisos en .android\cache).
// NDK 29 es >= 28.2 (compatible hacia atrás). Se usa plugins.withId (que corre
// al aplicarse el plugin de Android) en vez de afterEvaluate, porque
// evaluationDependsOn(":app") ya evalúa subproyectos.
subprojects {
    plugins.withId("com.android.library") {
        extensions.findByType(com.android.build.gradle.BaseExtension::class.java)
            ?.apply {
                ndkVersion = "29.0.14033849"
                buildToolsVersion = "36.1.0"
            }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
