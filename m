Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17BDC4332F
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Dec 2022 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiLLMVi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Dec 2022 07:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLMVg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Dec 2022 07:21:36 -0500
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 04:21:35 PST
Received: from mailout.dotplex.com (mailout.dotplex.com [185.231.124.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741764EB
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Dec 2022 04:21:34 -0800 (PST)
Received: from remote.ip.hidden (remote.ip.hidden [127.0.0.1])
        (Authenticated sender: estellnb@elstel.org)
        by mailout.dotplex.com (Postfix) with ESMTPSA id 1BB2D1FDDD
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Dec 2022 13:12:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elstel.org;
        s=dotplex1; t=1670847157;
        bh=f/W/GqIsuQ5POpMDxr3ftiv5tGEL0k2QFPgT9pUQyAQ=;
        h=Date:From:Subject:To;
        b=OkhbolTIlDc1Jn5H3Az2ZqPMYjXxO3gq5EqkMnGVJOD31AmDpQ3JmyrzEBPN/KMFU
         MyJ97TOvxC2zmph5LxfZuNnJQC68765lrQCORalVPE5FJRkRUlTaJekp1njcD9NO+C
         JARx1GE/pCRsbzq+rUCi+vu/3kE8zXDBbbmYD0gGQQgEcSjXtRg8ikoxG9KfAedJOR
         tFN04x/LYeXFZDZ1hb3pJEsoICyWRkslOzQf2v6fPY7izTkO/+rkGI0QH+fA9F6Myc
         rMrmO4LGeJ06oIYW2tKfaaYSXk8FcH1otav8PCA/dp8EPGIEz2x54xPm7obpR19Yj4
         cxd6CWtoMZDjA==
Message-ID: <560b51c6-a6b8-a315-f5b5-307e393f6ef8@elstel.org>
Date:   Mon, 12 Dec 2022 13:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Elmar Stellnberger <estellnb@elstel.org>
Subject: making uvesafb work on i586
To:     linux-fbdev@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

   I am debugging/testing glx and suspend issues on an i586 computer. 
With the vesa driver suspend works and there are no glx problems (since 
it does not support glx). However it only allows for 800x600 instead of 
1024x768 and no external monitor. Now I thought that a framebuffer based 
solution would work best on this computer. However if I want to

> modprobe uvesafb
uvesafb: failed to execute /sbin/v86d
uvesafb: getting VBE info block failed (eax=0x4f00, err=-2)
uvesafb: vbe_init failed with -22

   However there is no sense to have an v86d on an i586 system since you 
would not like to emulate code that is running natively on this machine!
What about a fix for this issue?

   Secondly I have discovered that echo 0 
 >/sys/class/vtconsole/vtcon1/bind hangs my system if nouveau is loaded 
and modesettting isn´t disabled. I was working on the console without 
running an X-server. That seems to be a bug and a regression, too, since 
I remember that having worked in order to switch to another console 
graphics mode driver.


see also: https://sourceforge.net/p/linux-fbdev/bugs/10/
regarding my debugging/testing efforts you may want to have a look at:
https://bugs.mageia.org/show_bug.cgi?id=31227

