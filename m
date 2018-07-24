From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 17:09:24 +0000
Subject: Re: [PATCH] efifb: BGRT: Do not copy the boot graphics for non native resolutions
Message-Id: <7824521.di82yjI1qK@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180716134549epcas2p4d829ac8115d54ef324bce42821536dd2@epcas2p4.samsung.com>
 <20180716134543.26091-1-hdegoede@redhat.com>
In-Reply-To: <20180716134543.26091-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, July 16, 2018 03:45:43 PM Hans de Goede wrote:
> On x86 some firmwares use a low non native resolution for the display when
> they have shown some text messages. While keeping the bgrt filled with info
> for the native resolution. If the bgrt image intended for the native
> resolution still fits, it will be displayed very close to the right edge of
> the display looking quite bad.
> 
> This commits adds a (heuristics based) checks for this and makes efifb
> not show the boot graphics when this is the case.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

