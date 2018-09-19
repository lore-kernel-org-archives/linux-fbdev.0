From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Sep 2018 12:12:40 +0000
Subject: Re: [PATCH 2/2] video: ssd1307fb: Do not hard code active-low reset sequence
Message-Id: <CAOMZO5CtaphPBXSkuRxX37Zbbx9oogXjy13TsRPgtR6y87gAdA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com> <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi Michal,

On Wed, Sep 19, 2018 at 6:18 AM, Michal Vokáč <michal.vokac@ysoft.com> wrote:
> The SSD130x OLED display reset signal is active low. Now the reset
> sequence is implemented in such a way that users are forced to
> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
>
> Do not hard code the active-low sequence into the driver but instead
> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
> the real world.
>
> The only single in-tree user of the display is converted and builds
> fine.
>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> I am not really sure wheater this should be in one commit or the DT
> changes should be done in separate commit. Just tell me and I will
> split/merge the changes as you want. Thanks.

Please separate in two patches: one for the dts and another for the driver.

Thanks
