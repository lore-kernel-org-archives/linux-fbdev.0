From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Mon, 31 Jul 2017 19:30:25 +0000
Subject: Re: [PATCH v2 0/2] Invert margin colors when terminal is inverted
Message-Id: <20170731203025.6a59fdbd@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501528185-9976-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501528185-9976-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

On Mon, 31 Jul 2017 14:09:43 -0500
David Lechner <david@lechnology.com> wrote:

> This is v2 of "fbcon: Use background color for margins=E2=80=8B"[1].
>=20
> It turns out that using the text background color was not a good choice. =
So,
> I've started over.

Can you explain why making the margins simply match the border colour
(when possible) isn't a better option ? They are after all simply
software extensions to the border.

Alan
