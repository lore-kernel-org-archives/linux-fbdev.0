From: Brian Masney <masneyb@onstation.org>
Date: Mon, 15 Apr 2019 12:42:36 +0000
Subject: Re: [PATCH v3 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190415124236.GA1910@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-3-masneyb@onstation.org>
 <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
In-Reply-To: <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Murphy <dmurphy@ti.com>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

On Mon, Apr 15, 2019 at 07:10:04AM -0500, Dan Murphy wrote:
> I noticed we are missing "label".  It is defined as optional and it is hard coded in the driver
> but wondering if there is a need to add it.

OK, I'll make it optional and have it fall back to the hardcoded values
if it is missing.

Thanks for the quick feedback on this patch and the other one.

Brian
