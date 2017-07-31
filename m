From: David Lechner <david@lechnology.com>
Date: Mon, 31 Jul 2017 20:43:38 +0000
Subject: Re: [PATCH v2 0/2] Invert margin colors when terminal is inverted
Message-Id: <80ad0768-069f-a7e7-2f4f-c0ed6b58b910@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501528185-9976-1-git-send-email-david@lechnology.com>
 <20170731203025.6a59fdbd@alans-desktop>
In-Reply-To: <20170731203025.6a59fdbd@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

On 07/31/2017 02:30 PM, Alan Cox wrote:
> On Mon, 31 Jul 2017 14:09:43 -0500
> David Lechner <david@lechnology.com> wrote:
>=20
>> This is v2 of "fbcon: Use background color for margins=E2=80=8B"[1].
>>
>> It turns out that using the text background color was not a good choice.=
 So,
>> I've started over.
>=20
> Can you explain why making the margins simply match the border colour
> (when possible) isn't a better option ? They are after all simply
> software extensions to the border.
>=20

So, basically, you are proposing that it would be better to add a module=20
parameter to select the margin color? That does sound like a better=20
option to me.
