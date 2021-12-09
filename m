Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75193C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Dec 2021 16:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbhLIQn3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:43:29 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:42096 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbhLIQn3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Dec 2021 11:43:29 -0500
X-Greylist: delayed 2352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 11:43:28 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uQm73i/SP9nDAwtnCDdFJdGwSWts5HhgvbF+8/OlYWI=; b=niubyPA5iUr8u1NrlH8/EszIgN
        izee9wd9bTJMaselSh4RK/XNr2psA8MWTmJsGuDRR9ZHGUn1FC/OXNBs+J2tr9btf1r9Atg6ZKoOV
        M6qy8zuJofVZcHN1E4hDmbUFS8aPTuckD26T5EPDXjCqQoVENpVJ4XKx2EpugQMZcU82n9sAdmtr/
        XTWkiR6ibFILabpmDCnHzWwIA8EB3pvdGRSdgGdLwZao8oUS7kRfan36IrjsGWLhghe8ofYhli2yJ
        gRtPpHRpFM61JJzRFrIFQD3ML7jt5+HFn5lmds9hwZ+xBKETz4xZLCFceiqVleKqS9M5aPgN9+E3N
        sBOE9/gQ==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mvLqG-0008HM-8F; Thu, 09 Dec 2021 17:00:20 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Reuse framebuffer after a kexec (amdgpu / efifb)
To:     linux-fbdev@vger.kernel.org, kexec@lists.infradead.org,
        amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, pjones@redhat.com,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kraxel@redhat.com,
        kasong@redhat.com,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        gpiccoli@igalia.com, kernel@gpiccoli.net
Message-ID: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
Date:   Thu, 9 Dec 2021 13:00:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi all, I have a question about the possibility of reusing a framebuffer
after a regular (or panic) kexec - my case is with amdgpu (APU, aka, not
a separate GPU hardware), but I guess the question is kinda generic
hence I've looped most of the lists / people I think does make sense
(apologies for duplicates).


The context is: we have a hardware that has an amdgpu-controlled device
(Vangogh model) and as soon as the machine boots, efifb is providing
graphics - I understand the UEFI/GRUB outputs rely in EFI framebuffer as
well. As soon amdgpu module is available, kernel loads it and it takes
over the GPU, providing graphics. The kexec_file_load syscall allows to
pass a valid screen_info structure, so by kexec'ing a new kernel, we
have again efifb taking over on boot time, but this time I see nothing
in the screen. I've manually blacklisted amdgpu in this new kexec'ed
kernel, I'd like to rely in the simple framebuffer - the goal is to have
a tiny kernel kexec'ed. I'm using kernel version 5.16.0-rc4.

I've done some other experiments, for exemple: I've forced screen_info
model to match VLFB, so vesafb took over after the kexec, with the same
result. Also noticed that BusMaster bit was off after kexec, in the AMD
APU PCIe device, so I've set it on efifb before probe, and finally
tested the same things in qemu, with qxl, all with the same result
(blank screen).
The most interesting result I got (both with amdgpu and qemu/qxl) is
that if I blacklist these drivers and let the machine continue using
efifb since the beginning, after kexec the efifb is still able to
produce graphics.

Which then led me to think that likely there's something fundamentally
"blocking" the reuse of the simple framebuffer after kexec, like maybe
DRM stack is destroying the old framebuffer somehow? What kind of
preparation is required at firmware level to make the simple EFI VGA
framebuffer work, and could we perform this in a kexec (or "save it"
before the amdgpu/qxl drivers take over and reuse later)?

Any advice is greatly appreciated!
Thanks in advance,


Guilherme
