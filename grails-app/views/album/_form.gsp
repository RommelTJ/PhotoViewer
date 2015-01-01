<%@ page import="com.photo.Album" %>



<div class="fieldcontain ${hasErrors(bean: albumInstance, field: 'caption', 'error')} ">
	<label for="caption">
		<g:message code="album.caption.label" default="Caption" />
		
	</label>
	<g:textField name="caption" maxlength="40" value="${albumInstance?.caption}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: albumInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="album.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="1024" value="${albumInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: albumInstance, field: 'pictures', 'error')} ">
	<label for="pictures">
		<g:message code="album.pictures.label" default="Pictures" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${albumInstance?.pictures?}" var="p">
    <li><g:link controller="picture" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="picture" action="create" params="['album.id': albumInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'picture.label', default: 'Picture')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: albumInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="album.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.photo.User.list()}" optionKey="id" required="" value="${albumInstance?.user?.id}" class="many-to-one"/>

</div>

