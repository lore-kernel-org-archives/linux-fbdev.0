From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 27 Apr 2020 08:36:06 +0000
Subject: Re: [PATCH] drivers/video: cleanup coding style in video a bit
Message-Id: <9ffb6645-5802-3163-2107-435392a777f6@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200427080530.3234-1-bernard@vivo.com>
In-Reply-To: <20200427080530.3234-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bernard Zhao <bernard@vivo.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: opensource.kernel@vivo.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Uma Shankar <uma.shankar@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Shashank Sharma <shashank.sharma@intel.com>

> Eliminate the magic numbers, add vender infoframe size macro
> like other hdmi modules.

How do you think about a wording variant like the following?

   Subject:
   [PATCH v2] video/hdmi: Use “HDMI_VENDOR_INFOFRAME_SIZE” in hdmi_vendor_infoframe_init()

   Change description:
   Adjust the usage of a “magic” number here by adding a macro for
   the vendor info frame size (similar to other video modules).


Regards,
Markus
