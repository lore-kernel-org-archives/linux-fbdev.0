From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 21 Mar 2010 03:25:22 +0000
Subject: Re: [PATCH v2 2/6] hid: add framebuffer support to PicoLCD device
Message-Id: <20100321032522.GD29360@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100320170014.440959a8@neptune.home>
 <20100320170415.6ee219c8@neptune.home>
In-Reply-To: <20100320170415.6ee219c8@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sat, Mar 20, 2010 at 05:04:15PM +0100, Bruno Pr=E9mont wrote:
> +static inline int picolcd_fb_send_tile(struct hid_device *hdev, int chip,
> +		int tile)
> +{

You seemt o be fond of the 'inline; attribute ;) I don't think that a
40 lines function qualifies. Please lose inlines on functions that are
not in .h files and are not stubs.

--=20
Dmitry
