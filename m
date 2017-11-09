From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:10:55 +0000
Subject: Re: [PATCH 2/3] sm501fb: unregister framebuffer only if registered
Message-Id: <9342855.lU0InW62AW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
        <CGME20171104212430epcas1p428fa8d0e3fa14f232df9b0e7b14cbaaf@epcas1p4.samsung.com>
        <1509830661-7384-2-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1509830661-7384-2-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Saturday, November 04, 2017 09:24:20 PM Sudip Mukherjee wrote:
> There are cases when panel and crt both are not defined and only one of
> them is defined and initialized. In such cases, while removing the
> device, unregister the framebuffer only if it was registered.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

