From: Jiri Kosina <jkosina@suse.cz>
Date: Mon, 29 Mar 2010 09:44:23 +0000
Subject: Re: [PATCH v3 6/6] hid: add experimental access to PicoLCD device's
Message-Id: <alpine.LNX.2.00.1003291142400.24576@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100324233707.7243b04d@neptune.home> <20100324235835.0e7e1bcb@neptune.home>
In-Reply-To: <20100324235835.0e7e1bcb@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 24 Mar 2010, Bruno Pr=C3=A9mont wrote:

> +static ssize_t picolcd_debug_reset_open(struct inode *inode, struct file=
 *f)
> +{
> +	return single_open(f, picolcd_debug_reset_show, inode->i_private);
> +}
> +

struct file_operations->open is supposed to return int (filedescriptor),=20
not ssize_t.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
