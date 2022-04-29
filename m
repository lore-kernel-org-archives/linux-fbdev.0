Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3938C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 07:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiD2HlY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiD2HlY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 03:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B5F1A2041
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651217886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn4pMYCmP9rxbFuOxBBTfXkTBUlRDnMPeAj96w8G82w=;
        b=gUOHMlD9oS4QcQBRkogCzvCHBBSC6KjO7qx7p/+LFhBOCRuTDeYM8mxcFicmOFuLyuWM69
        detd3Cg5EBXn+lFcKfgpCxJ0yL6nQha3Ca43Wpgn8tZOlpYp3TnPl04n7WyBFSqth13TiQ
        0VIK++RGKLm6lij9P30Cvzh6xO3jmi4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-UhDnSz2CNoKzWcipYMBbEg-1; Fri, 29 Apr 2022 03:38:04 -0400
X-MC-Unique: UhDnSz2CNoKzWcipYMBbEg-1
Received: by mail-wr1-f70.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso2745829wrb.13
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 00:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sn4pMYCmP9rxbFuOxBBTfXkTBUlRDnMPeAj96w8G82w=;
        b=vqwz534+xfG4x2BtgKdN2naZEICLgChB15E+dscQ3Yyn5ackZD0bGy8pRWc3RF4ogN
         iW+1IVTlhLE5qugglB0I1vd5U1t/ZdbuZpcfwtNQ+JA738UP51vO3sGNHsW/7Mtb2tSd
         oYd5OxeiiS2ZYGT2Xz703l3kFPckVBLC996S5jjdYQUNC/uml7Yh3Sp6KvA/AgN6NKjX
         WDU7mrmZUSiL90AEVcx0fBwdtsyFqmPnvWSlHAXy0FJfM1WR+vTwu6u7sb4/k1FaqHCI
         IFEZ87aQoCPCDRoG2c0Wv2M2wL8KSaTx9J2EUZXsFw6Y7lsIe1cR+mdfsPNwDVLGCAMg
         JNvA==
X-Gm-Message-State: AOAM533lAbpl6USWsO3DtP71dMB9hi/N2JjvJRzFjAA0G3unBjeihpAz
        1fRyk9J91mqXnntJtR8N8uvEk2kMY+bDI21EfzhjUHFhka+yurLwI25Tlq2YNcZI7CGkVYCbvRo
        3JQI/yhBxW+QSKLjGoGKMuUY=
X-Received: by 2002:a5d:6d81:0:b0:20c:4c82:7239 with SMTP id l1-20020a5d6d81000000b0020c4c827239mr472034wrs.254.1651217883272;
        Fri, 29 Apr 2022 00:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyit0aCIjTyFDElOW1X8rM+bZwRMXA3FEqwxP6W9A3I3zSFPQgJfGjftv7TUU0fTJmPW3u3w==
X-Received: by 2002:a5d:6d81:0:b0:20c:4c82:7239 with SMTP id l1-20020a5d6d81000000b0020c4c827239mr472018wrs.254.1651217883025;
        Fri, 29 Apr 2022 00:38:03 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce354sm2046162wrc.76.2022.04.29.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:38:02 -0700 (PDT)
Message-ID: <4265064b-9250-c05e-6d54-cf97c7f1cf4e@redhat.com>
Date:   Fri, 29 Apr 2022 09:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 4/5] fbdev: Rename pagelist to pagereflist for deferred
 I/O
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, airlied@linux.ie, maarten.lankhorst@linux.intel.com
Cc:     linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
References: <20220426120359.17437-1-tzimmermann@suse.de>
 <20220426120359.17437-5-tzimmermann@suse.de>
 <ac24d81e-f6c5-0763-909a-c15d223f1ea9@redhat.com>
 <91f562b5-1b8e-1445-b6b5-5aeb6cd7668a@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <91f562b5-1b8e-1445-b6b5-5aeb6cd7668a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 4/29/22 09:27, Thomas Zimmermann wrote:
> Hi
> 
> Am 29.04.22 um 09:21 schrieb Javier Martinez Canillas:
>> Hello Thomas,
>>
>> On 4/26/22 14:03, Thomas Zimmermann wrote:
>>> Rename various instances of pagelist to pagereflist. The list now
>>> stores pageref structures, so the new name is more appropriate.
>>>
>>> In their write-back helpers, several fbdev drivers refer to the
>>> pageref list in struct fb_deferred_io instead of using the one
>>> supplied as argument to the function. Convert them over to the
>>> supplied one. It's the same instance, so no change of behavior
>>> occurs.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
>>
>> I thougt the convention was to have Suggested-by before your S-o-B.
> 
> I always thought that the convention was that the authors S-o-B goes 
> first. But 'git log' indeed indicates otherwise. I will change this 
> before merging the patch.
> 

The way I understand it, is that besides other things it indicates a
chronological order of events. So the S-o-B will go first, followed
by any Reviewed-by, Acked-by, etc gathered.

But if someone suggests a change to you, that means the suggestion
happened before you wrote the patch and is expected to go first.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

