From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 4/5] x86_64 EFI support -v3: EFI framebuffer driver
Date: Mon, 30 Jul 2007 22:34:12 -0600
Message-ID: <m1zm1dtcmz.fsf@ebiederm.dsl.xmission.com>
References: <1185851582.23149.29.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S969624AbXGaElt@vger.kernel.org>
In-Reply-To: <1185851582.23149.29.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Tue, 31 Jul 2007 11:13:02 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Huang, Ying" <ying.huang@intel.com>
Cc: ak@suse.de, akpm@linux-foundation.org, Yinghai Lu <yhlu.kernel@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, Chandramouli Narayanan <mouli@linux.intel.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> This patch adds Graphics Output Protocol support to the kernel.
> UEFI2.0 spec deprecates Universal Graphics Adapter (UGA) protocol and
> only Graphics Output Protocol (GOP) is produced. Therefore, the boot
> loader needs to query the UEFI firmware with appropriate Output
> Protocol and pass the video information to the kernel. As a result of
> GOP protocol, an EFI framebuffer driver is needed for displaying
> console messages. The patch adds a EFI framebuffer driver. The EFI
> frame buffer driver in this patch is based on the Intel Mac
> framebuffer driver.
>
> The ELILO bootloader takes care of passing the video information as
> appropriate for EFI firmware.

Am I correct in understanding that you are not using any of the efi
runtime service infrastructure you have built up in other patches?

So far this looks like the only useful piece of the patchset.
If this doesn't use the runtime services I don't see any point
in having them.

Eric
