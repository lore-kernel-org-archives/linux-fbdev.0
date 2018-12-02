From: Frank Lee <tiny.windzz@gmail.com>
Date: Sun, 02 Dec 2018 04:16:37 +0000
Subject: Re: [PATCH v2] media: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE
Message-Id: <CAEExFWtu0LLgNgNtW9QM16cZA337A7QGQc+XKd2fnX-7tfQTfQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181202041448.10049-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202041448.10049-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, fengguang.wu@intel.com, mchehab+samsung@kernel.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 12:14 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
Changes in v2:
-Add a missing edit of dss_fops
---
