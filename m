From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 09 Oct 2018 12:36:51 +0000
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <CAOMZO5DdV9Sm9z6wX8e4LTvbokjnOMqtgOJQOvVvysVvzaBKGw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com> <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
 <20181009002031.GU3587@dragon> <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
 <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
In-Reply-To: <bfbfd490-3872-2fd9-e088-3add596b987c@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

Hi Michal,

On Tue, Oct 9, 2018 at 5:30 AM Vokáč Michal <Michal.Vokac@ysoft.com> wrote:

> Sorry for the inconvenience :( Lesson learned..
>
> So in other words (no offense): broken drivers need to stay broken because
> users may already get used to the broken behavior?

In order to keep the old dtb's working you could introduce a new
property (like reset-gpio-active-low, for example).

Then the driver behavior can be made untouched for the old dtb's and
only new dtb's with this new property would have the correct GPIO
reset behavior.
