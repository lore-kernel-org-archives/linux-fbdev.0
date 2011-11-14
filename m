From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 14 Nov 2011 20:25:37 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111114212537.791bc507@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 14 November 2011 "D.J.J. Ring, Jr." <n1ea@arrl.net> wrote:
> I am sorry Anatolij,
> 
> I should have said that I DID run sudo update-grub and then I rebooted.
> 
> When it rebooted, I still have the "no /dev/fb0" error.
> 
> I apologize for not being thourough in my words.

Please make sure "nomodeset" is no more present on kernel cmdline and
if it's gone post your corresponding kernel log (at least the relevant
parts of it like the few first line including cmdline and anything
that is related to drm, i915, *fb*, vesa or vga)!

Note, with grub you should also be able to edit the kernel cmdline from
grubs interface before you tell it to boot the kernel.
You could even attempt to reboot with kexec (where you can choose kernel
and cmdline as well) if you can't convince grub.

Bruno
