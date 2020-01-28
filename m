From: Rich Felker <dalias@libc.org>
Date: Tue, 28 Jan 2020 18:58:19 +0000
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
Message-Id: <20200128185819.GG30412@brightrain.aerifal.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200125195506.GA16638@brightrain.aerifal.cx>
 <1466259e-efe7-df52-c05b-80042628d577@suse.de>
In-Reply-To: <1466259e-efe7-df52-c05b-80042628d577@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Jan 27, 2020 at 08:36:07AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.01.20 um 20:55 schrieb Rich Felker:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > --
> > I've had this lying around a while and figure I should send it
> > upsteam; it's needed to support the onboard video on my Spectre-free
> > Atom S1260 server board.
> 
> This HW is supported by mgag200, which is maintained. Can't you use that?

Perhaps; I wasn't aware it existed. I'll give it a try. It still might
be nice to apply my patch though since the matroxfb driver works with
it and only fails to support it because of not knowing the device id.

Rich
