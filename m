From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 16 Jul 2019 12:26:14 +0000
Subject: Re: [PATCH 03/10] video: pxafb: Remove cpufreq policy notifier
Message-Id: <648e2ab5-afd7-3b9c-de8b-1e14c0be83e2@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
        <e69d47b1d497bdbd8c988754d98714e78ddc0a80.1563270828.git.viresh.kumar@linaro.org>
        <CGME20190716122625eucas1p2093f157267d4ad2ca6757496ed690c90@eucas1p2.samsung.com>
In-Reply-To: <e69d47b1d497bdbd8c988754d98714e78ddc0a80.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 7/16/19 11:54 AM, Viresh Kumar wrote:
> The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
> get removed soon.
> 
> The notifier callback pxafb_freq_policy() isn't doing anything apart
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
