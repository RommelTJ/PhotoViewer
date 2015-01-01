
<%@ page import="com.photo.Picture" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'picture.label', default: 'Picture')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pictureInstance}">
            <div class="errors">
                <g:renderErrors bean="${pictureInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${pictureInstance?.id}" />
                <g:hiddenField name="version" value="${pictureInstance?.version}" />
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
                                    <g:select name="album.id" from="${com.photo.Album.findAllByUser(pictureInstance.user)}" optionKey="id" value="${pictureInstance?.album?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="picture.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'user', 'errors')}">
                                	<g:link controller="user" action="show" id="${pictureInstance?.user?.id}">
	                                	${pictureInstance?.user}
	                                </g:link>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="rawImage"><g:message code="picture.rawImage.label" default="Photo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pictureInstance, field: 'rawImage', 'errors')}">
			                    	<img src="${createLink(action:'displayMediumPhoto', id:pictureInstance.id)}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
