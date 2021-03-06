<#include "macro-admin.ftl">
<#include "../macro-pagination.ftl">
<@admin "articles">
<div class="list content admin">
    <div class="fn-hr10"></div>
    <form method="GET" action="${servePath}/admin/articles" class="form wrapper">
        <input name="id" type="text" placeholder="${articleLabel} Id"/>
        <button type="submit" class="green">${searchLabel}</button>
        <#if esEnabled || algoliaEnabled>
        <button type="button" class="btn red" onclick="searchIndex();">${searchIndexLabel}</button>
        </#if>
        <button type="button" class="btn red" onclick="window.location = '${servePath}/admin/add-article'">${addArticleLabel}</button>
    </form>
    <ul>
        <#list articles as item>
        <li>
            <div class="fn-clear first">
                <div class="avatar" style="background-image:url('${item.articleAuthorThumbnailURL20}')"></div>
                <a href="${item.articlePermalink}">${item.articleTitle}</a> 
                <#if item.articleStatus == 0>
                <span class="ft-gray">${validLabel}</span>
                <#else>
                <font class="ft-red">${banLabel}</font>
                </#if>
                <#if 0 < item.articleStick>
                <#if 9223372036854775807 <= item.articleStick><font class="ft-green">${adminLabel}</font></#if><font class="ft-green">${stickLabel}</font>
                </#if>
                <a href="${servePath}/admin/article/${item.oId}" class="fn-right icon-edit" title="${editLabel}"></a>  
            </div>
            <div class="fn-hr5"></div>
            <div>
                <span class="icon-tags" title="${tagLabel}"></span>
                <span class="tags">
                    ${item.articleTags}
                </span> 
            </div>
            <div class="fn-hr5"></div>
            <div class="ft-gray fn-clear">
                <span class="icon-view fn-right" title="${viewCountLabel}"> ${item.articleViewCount}</span>
                <span class="icon-cmts fn-right" title="${commentCountLabel}"> ${item.articleCommentCount} &nbsp;</span>
                <span class="icon-date" title="${createTimeLabel}"></span>
                ${item.articleCreateTime?string('yyyy-MM-dd HH:mm')}
            </div>

        </li>
        </#list>
    </ul>
    <@pagination url="${servePath}/admin/articles"/>
</div>

<script>
    function searchIndex() {
        $.ajax({
            url: "/admin/search/index",
            type: "POST",
            cache: false,
            success: function (result, textStatus) {
                window.location.reload();
            }
        });
    }
</script>
</@admin>
