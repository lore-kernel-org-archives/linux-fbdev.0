From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 25 May 2015 09:48:42 +0000
Subject: Re: fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150525094842.GB22558@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150523173245.GA31663@mwanda>
In-Reply-To: <20150523173245.GA31663@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, May 25, 2015 at 10:30:38AM +0530, Sudip Mukherjee wrote:
> On Sat, May 23, 2015 at 08:32:45PM +0300, Dan Carpenter wrote:
> > Hello Thomas Niederpr=FCm,
>=20
> > But I also have a hard time remembering if | or << is higher precedence
>=20
> man page of operator (man operator) will show the precedence.
> << is higher precendence than |

The point is that people should just use parenthesis when it's not
something that's obvious.

Also the more I think about it, writing "!par->com_seq & 0x1" is
nonsense.  If that's really what was intended then just say
"!par->com_seq".  I think it's a bug though and "!(par->com_seq & 0x1)"
is intended.

regards,
dan carpenter
