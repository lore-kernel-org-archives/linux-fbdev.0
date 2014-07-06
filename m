From: Marek Vasut <marex@denx.de>
Date: Sun, 06 Jul 2014 21:06:59 +0000
Subject: Re: [PATCH] video: fbdev: mxsfb.c:  Cleaning up variable that is never used
Message-Id: <201407062306.59317.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404672272-19231-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404672272-19231-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lothar =?iso-8859-1?q?Wa=DFmann?= <LW@karo-electronics.de>, Jingoo Han <jg1.han@samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sunday, July 06, 2014 at 08:44:32 PM, Rickard Strandqvist wrote:
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Makes perfect sense.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
