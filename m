From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [GIT PATCH] Geode patches for 2.6.17
Date: Fri, 23 Jun 2006 16:25:32 -0400
Message-ID: <449C4E3C.7000107@garzik.org>
References: <20060623170058.GA12819@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751976AbWFWUZf@vger.kernel.org>
In-Reply-To: <20060623170058.GA12819@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

Jordan Crouse wrote:
> Hi - 
> 
> Please consider pulling from:
> git://git.infradead.net/users/jcrouse/geode.git linus-upstream
> 
> This is the new home for patches for the AMD Geode family of processors.
> 
> For 2.6.18, we offer up patches to support the One Laptop
> Per Child effort - namely framebuffer tweaks, plus an attempt to remove
> automagic probing of VGA registers (which we don't have on the OLPC
> platform).
> 
> Here is the shortlog:
> 
> Jordan Crouse:
>       GEODE: Update and fixup the PCI IDs for the CS5535
>       FB: Get the Geode GX frambuffer size from the BIOS
>       Add a configuration option to avoid automatically probing VGA
>       gxfb: Fixups for the AMD Geode GX framebuffer driver

When you send a 'please pull' message, two additional things are needed:
* output of 'diffstat -p1'
* the patches themselves, either in this email, or spread out across 
several emails in the same email thread (linked together with RFC822 
References header)

	Jeff
