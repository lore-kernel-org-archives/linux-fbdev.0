Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6BC4332F
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Nov 2022 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiKDOtO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKDOsw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 4 Nov 2022 10:48:52 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Nov 2022 07:48:40 PDT
Received: from chronos.abteam.si (chronos.abteam.si [IPv6:2a01:4f8:140:90ea::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6731FA2
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Nov 2022 07:48:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by chronos.abteam.si (Postfix) with ESMTP id CE4AE5D0009F
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Nov 2022 15:41:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bstnet.org; h=
        content-transfer-encoding:content-type:content-type:subject
        :subject:from:from:content-language:user-agent:mime-version:date
        :date:message-id; s=default; t=1667572915; x=1669387316; bh=pHap
        QSQ4H883EUWWNvq261cfDDkMm+K45YuRuvjes8g=; b=V8sQA3O/2JXpRqK0UJYW
        Ohz2cgwe86LcVdl2+644OOJ/gP+NimxsY/sP3J0omHgpln/vploi/gtbUASDDuHz
        th8ffBVKbrCDcfFSh0xjSb451c8heZCvrlKw9ZjH42dm5XqIm0Tdm2MejxvvKt3L
        3YWYRnw56ODGwt1P8hNeMMU=
X-Virus-Scanned: Debian amavisd-new at chronos.abteam.si
Received: from chronos.abteam.si ([127.0.0.1])
        by localhost (chronos.abteam.si [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id uoAA-Ede0jfH for <linux-fbdev@vger.kernel.org>;
        Fri,  4 Nov 2022 15:41:55 +0100 (CET)
Received: from [IPV6:2a00:ee2:4d00:602:1216:21cb:4f5e:ef4a] (unknown [IPv6:2a00:ee2:4d00:602:1216:21cb:4f5e:ef4a])
        (Authenticated sender: boris@abteam.si)
        by chronos.abteam.si (Postfix) with ESMTPSA id 92DF75D0009E
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Nov 2022 15:41:55 +0100 (CET)
Message-ID: <1e7fafae-4b1b-4d9d-d619-b1a61d214c8a@bstnet.org>
Date:   Fri, 4 Nov 2022 15:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     linux-fbdev@vger.kernel.org
From:   "Boris V." <borisvk@bstnet.org>
Subject: With 6.0.4 kernel, framebuffer on GPU1 is disabled, if vfio-pci
 driver is used for GPU2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

not sure where is the right place to post this.
I already posted reply to patch that caused this 
https://lore.kernel.org/lkml/ba4caf7a-9e1f-d5fb-f20c-dba81dc00c06@bstnet.org/

Problem is that after kernel 6.0.4 console/framebuffer on GPU 1 is 
disabled, if GPU 2 is bound to vfio-pci driver.
Git bisect lead to commit af9ac541e88390d97b01d5e8c77309d2637c1d4c.
After this patch sysfb_disable() is always called. Before it was not.
Maybe it should be "if (primary) sysfb_disable();" or check if framebuffer
is used on pci_dev passed to aperture_remove_conflicting_pci_devices() 
and only in this case call sysfb_disable()?
But I don't know how this things work.
Is this intended change? I see no reason to disable framebuffer/console 
on GPU 1, if GPU 2 is bound to vfio-pci driver.
And this was not the case until 6.0.4 kernel. Kernel 6.0.3 still works.
