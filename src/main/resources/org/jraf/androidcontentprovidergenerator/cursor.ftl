<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.nameLowerCase};

import java.util.Date;

import android.database.Cursor;

import ${config.providerJavaPackage}.base.AbstractCursor;

/**
 * Cursor wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}Cursor extends AbstractCursor {
    public ${entity.nameCamelCase}Cursor(Cursor cursor) {
        super(cursor);
    }
    <#list entity.fields as field>

    /**
     * Get the {@code ${field.nameLowerCase}} value.
     <#if field.isNullable>
     * Can be {@code null}.
     <#else>
     <#if !field.type.hasNotNullableJavaType()>
     * Cannot be {@code null}.
     </#if>
     </#if>
     */
    public ${field.javaTypeSimpleName} get${field.nameCamelCase}() {
        <#switch field.type.name()>
        <#case "STRING">
        Integer index = getCachedColumnIndexOrThrow(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return getString(index);
        <#break>
        <#case "INTEGER">
        return getIntegerOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "LONG">
        return getLongOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "FLOAT">
        return getFloatOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "DOUBLE">
        return getDoubleOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "BOOLEAN">
        return getBoolean(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "DATE">
        return getDate(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "BYTE_ARRAY">
        Integer index = getCachedColumnIndexOrThrow(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return getBlob(index);
        <#break>
        <#case "ENUM">
        Integer intValue = getIntegerOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        if (intValue == null) return null;
        return ${field.javaTypeSimpleName}.values()[intValue];
        <#break>
        </#switch>
    }
    </#list>
}
