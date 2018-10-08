From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:53:08 +0000
Subject: Re: [RESEND PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Message-Id: <20181008105310eucas1p1347f43171fe1e7cc8122711927a30bb0~bnLLu5wP61861618616eucas1p1i@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180927092738epcas5p28c53516b73fe7747133914f40c84d6c4@epcas5p2.samsung.com>
        <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


On 09/27/2018 11:24 AM, Michal Vokáč wrote:
> The reset signal can be produced by GPIO expander that can sleep.
> In that case the probe function fails. Allow using GPIO expanders for
> the reset signal by using the non-atomic gpiod_set_value_cansleep()
> function.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
