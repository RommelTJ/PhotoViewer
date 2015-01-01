
<%@ page import="com.photo.Picture" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'picture.label', default: 'Picture')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pictureInstance}">
            <div class="errors">
                <g:renderErrors bean="${pictureInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post"  enctype="multipart/form-data">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="caption"><g:message code="picture.caption.label" default="Caption" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'caption', 'errors')}">
                                    <g:textField name="caption" maxlength="40" value="${pictureInstance?.caption}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="picture.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" cols="40" rows="5" value="${pictureInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="album"><g:message code="picture.album.label" default="Album" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'album', 'errors')}">
                                    <g:select name="album.id" from="${com.photo.Album.list()}" optionKey="id" value="${pictureInstance?.album?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="picture.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.photo.User.list()}" optionKey="id" value="${pictureInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rawImage"><g:message code="picture.rawImage.label" default="Raw Image" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'rawImage', 'errors')}">
                                    <input type="file" id="rawImage" name="rawImage" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
