From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Date: Mon, 21 Feb 2005 03:37:45 -0500
Message-ID: <42199DD9.10807@pobox.com>
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105022023242e2fd9ce@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>

Jon Smirl wrote:
> I haven't been able to come up with a reliable way to call a user
> space reset program from a driver's probe function except with an
> in-kernel emu86. Is there another way? I'd also like to try an find a
> solution that doesn't need to modify the 73 existing framebuffer
> drivers.


You either need to execute the video BIOS to initialize the hardware 
registers, or initialize the hardware registers themselves.

	Jeff
