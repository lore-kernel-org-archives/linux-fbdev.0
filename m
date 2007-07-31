From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 4/5] x86_64 EFI support -v3: EFI framebuffer driver
Date: Tue, 31 Jul 2007 14:35:08 +0800
Message-ID: <1185863708.23149.46.camel@caritas-dev.intel.com>
References: <1185851582.23149.29.camel@caritas-dev.intel.com>
	 <m1zm1dtcmz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756931AbXGaGfh@vger.kernel.org>
In-Reply-To: <m1zm1dtcmz.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ak@suse.de, akpm@linux-foundation.org, Yinghai Lu <yhlu.kernel@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, Chandramouli Narayanan <mouli@linux.intel.com>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, linux-kernel@vger.kernel.org

On Mon, 2007-07-30 at 22:34 -0600, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > This patch adds Graphics Output Protocol support to the kernel.
> > UEFI2.0 spec deprecates Universal Graphics Adapter (UGA) protocol and
> > only Graphics Output Protocol (GOP) is produced. Therefore, the boot
> > loader needs to query the UEFI firmware with appropriate Output
> > Protocol and pass the video information to the kernel. As a result of
> > GOP protocol, an EFI framebuffer driver is needed for displaying
> > console messages. The patch adds a EFI framebuffer driver. The EFI
> > frame buffer driver in this patch is based on the Intel Mac
> > framebuffer driver.
> >
> > The ELILO bootloader takes care of passing the video information as
> > appropriate for EFI firmware.
> 
> Am I correct in understanding that you are not using any of the efi
> runtime service infrastructure you have built up in other patches?

Yes. The EFI runtime service is not needed for this patch.

Best Regards,
Huang Ying
