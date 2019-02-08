From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:54:04 +0000
Subject: =?UTF-8?Q?Re:_[PATCH=ed=98=bbRESEND_v2_0/4]_Fix_ssd1307fb_OLED_driv?= =?UTF-8?Q?er_reset?=
Message-Id: <590890b7-f4ed-e346-8caa-8bb4ada43bc5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190128115430epcas1p243804249cd6c841166eb6cd5a504ce22@epcas1p2.samsung.com>
        <1548676383-29685-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1548676383-29685-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


On 01/28/2019 12:52 PM, Michal Vokáč wrote:
> Hi all,
> 
> this is my third attempt to fix the ssd1307fb OLED driver reset. In the
> second attempt [1] Rob suggested to take different aproach. That is to
> apply what was originaly part of the first round and eventually merged
> but reverted later on [2][3].
> 
> The last patch in this series is a fixup for the single user (in-tree)
> that uses this OLED. Rob suggested the fixup may actually be applied
> only after someone complains their display broke.
> 
> And a comment from Alexandre regarding the status of the Crystalfontz
> platform:
> 
> On 20.12.2018 13:35, Alexandre Belloni wrote:
>> Honestly, the platform has been discontinued and I don't really think
>> it is worth having that fixup in the tree forever.

Patches #1-3 queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
