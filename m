From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 03 May 2011 05:41:04 +0000
Subject: Re: Login prompt on a video console instead of serial port?
Message-Id: <1304401264.2513.303.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DBF065C.3030407@freescale.com>
	<BANLkTikWMksVsvs8KzjdiZfRR-2WGD0Ftw@mail.gmail.com>
	<4DBF0DF1.6050207@freescale.com>
In-Reply-To: <4DBF0DF1.6050207@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, 2011-05-02 at 15:02 -0500, Timur Tabi wrote:
> McClintock Matthew-B29882 wrote:
> > Don't you have to spawn a terminal on the framebuffer for the login?
> 
> I suppose, but I don't know how to do that.  And although that would technically
> answer the question in the subject of this thread, I still would have *some*
> boot output on the serial port.  It would be nice if I could get all of stdout
> on the video display, and all of stdin from the serial port.

I don't think we have a way to do that unless you can make a serial
"keyboard" device in the input layer. The VT layer will only get its
input from such a thing, maybe that does exist in the depth of legacy
code in there but it has nothing to do with your device-tree.

> > Right now getty spawns the login on the serial port via /etc/inittab.
> > Something similiar is probably needed for the framebuffer.
> 
> getty appears to work only with serial devices, since it insists on a baud rate
> as one of the parameters.

No, or no existing distro would work :-)

Just fake a baudrate for the tty's

Cheers,
Ben.

