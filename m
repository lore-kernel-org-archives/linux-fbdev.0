From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 06 Dec 2016 10:02:43 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161206100243.GA15139@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1480848836-11330-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1480848836-11330-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, andrey_utkin@fastmail.com, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 04, 2016 at 11:53:53AM +0100, Manuel Sch=F6lling wrote:
> Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
> Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
> Tested-by: Adam Borowski <kilobyte@angband.pl>
>=20
> --
> Changes in v7:
>   - Add new callback to consw struct for flushing video console driver's
>     scrollback buffer. Fixes issues with escape sequence '\e[3J' reported
>     by Adam Borowski (kilobyte@angband.pl).
>   - Fix style issues

But this is now v8, right?  I see two v7 patch series in my inbox :(

confused,

greg k-h
