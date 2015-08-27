From: "Johansson, Werner" <Werner.Johansson@sonymobile.com>
Date: Thu, 27 Aug 2015 22:51:09 +0000
Subject: RE: [PATCH] backlight: lp855x: Make sure props struct is zeroed
Message-Id: <3892D88DBE322D4FA4B7FE095FDA445A07C27BD1AFDC@seldmbx01.corpusers.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
 <55DF92BF.7030703@ti.com>
In-Reply-To: <55DF92BF.7030703@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kim, Milo" <milo.kim@ti.com>, =?iso-8859-1?Q?=22Andersson=2C_Bj=F6rn=22?= <Bjorn.Andersson@sonymobile.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> > From: Werner Johansson <werner.johansson@sonymobile.com>
> >
> > The driver occasionally got stuck in suspend mode or other strange
> > states as those parts of the props struct were never initialized.
> 
> Acked-by: Milo Kim <milo.kim@ti.com>
> 
> Thanks for catching this.

You're most welcome! These issues can be difficult to track down, the stack is unpredictable.. 

/wj 
