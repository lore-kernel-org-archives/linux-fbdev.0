From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Date: Mon, 21 Feb 2005 12:02:34 -0500
Message-ID: <421A142A.1060302@pobox.com>
References: <9e47339105022023242e2fd9ce@mail.gmail.com>	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105022108527e3c679d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>

Jon Smirl wrote:
> On Mon, 21 Feb 2005 03:37:45 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>You either need to execute the video BIOS to initialize the hardware
>>registers, or initialize the hardware registers themselves.
> 
> 
> That is what the user mode reset program does.
> 
> The problem is, how do I get it to run before calling the device's
> probe function? Most of the framebuffer drivers assume that the
> hardware has already been reset in their probe code.

<shrug>  You do precisely what you just said:  run it before the 
device's probe function.

That typically means either initramfs addition or using 'install 
<module> command...' in /etc/modprobe.conf.

	Jeff
