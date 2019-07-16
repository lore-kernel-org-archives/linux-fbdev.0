From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 16 Jul 2019 12:25:37 +0000
Subject: Re: [PATCH 02/10] video: sa1100fb: Remove cpufreq policy notifier
Message-Id: <8b0f9adf-8462-eeba-afd1-52201f4e7f47@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
        <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
        <CGME20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8@eucas1p2.samsung.com>
In-Reply-To: <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Viresh,

Please always Cc: me on fbdev patches.

On 7/16/19 11:54 AM, Viresh Kumar wrote:
> The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
> get removed soon.
> 
> The notifier callback sa1100fb_freq_policy() isn't doing anything apart
> from printing a debug message on CPUFREQ_ADJUST notification. There is
> no point in keeping an otherwise empty callback and registering the
> notifier.
> 
> Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
