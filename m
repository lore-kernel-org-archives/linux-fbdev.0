From: "Kim, Milo" <milo.kim@ti.com>
Date: Thu, 27 Aug 2015 22:44:15 +0000
Subject: Re: [PATCH] backlight: lp855x: Make sure props struct is zeroed
Message-Id: <55DF92BF.7030703@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1440697275-4469-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Werner Johansson <werner.johansson@sonymobile.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/28/2015 2:41 AM, Bjorn Andersson wrote:
> From: Werner Johansson <werner.johansson@sonymobile.com>
>
> The driver occasionally got stuck in suspend mode or other strange
> states as those parts of the props struct were never initialized.

Acked-by: Milo Kim <milo.kim@ti.com>

Thanks for catching this.
