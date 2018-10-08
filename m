From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:53:48 +0000
Subject: Re: [RESEND PATCH v2 2/3] video: ssd1307fb: Do not hard code active-low reset sequence
Message-Id: <20181008105350eucas1p2a16945864d1b9ca2bb15b9126b700f03~bnLxZUHUO1504015040eucas1p23@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <CGME20180927092739epcas5p48229ea32d3382e27602660e991efca09@epcas5p4.samsung.com>
        <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1538040281-21319-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


On 09/27/2018 11:24 AM, Michal Vokáč wrote:
> The SSD130x OLED display reset signal is active low. Now the reset
> sequence is implemented in such a way that users are forced to
> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
> 
> Do not hard code the active-low sequence into the driver but instead
> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
> the real world.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
