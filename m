From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Apr 2013 18:55:35 +0000
Subject: Re: [PATCH v8 0/3] Runtime Interpreted Power Sequences
Message-Id: <CAPnjgZ1P6dmRB0sO2qBUtd=WBiNcY339NAit2faaotAfEqQDeQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Mark Zhang <markz@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, linux-pm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>

Hi,

On Thu, Nov 15, 2012 at 10:38 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Hopefully the final series before the feature gets merged. Anton Vorontsov
> kindly accepted to take it into his tree, so this series is mostly a call for
> acks, tests and reviews notices before the merge window for 3.8 opens. If you
> are interested in seeing this feature, please add your name.
>
> This series also adds an entry for the subsystem into MAINTAINERS, setting me as
> the person in charge.
>
> Changes from v7:
> - fix bug reported by Tony Prisk
> - add MAINTAINERS entry
>
> Alexandre Courbot (3):
>   Runtime Interpreted Power Sequences
>   pwm_backlight: use power sequences
>   Take maintainership of power sequences

Did this actually land? I can't see it in linux-next.

Regards,
Simon
