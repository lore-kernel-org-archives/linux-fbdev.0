From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2019 10:06:08 +0000
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Message-Id: <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563269894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1563269894.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Erik Schmauss <erik.schmauss@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Javi Merino <javi.merino@kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, dri-devel <dri-devel@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, DOCUMENTATIO

On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> Now that cpufreq core supports taking QoS requests for min/max cpu
> frequencies, lets migrate rest of the users to using them instead of the
> policy notifiers.

Technically, this still is linux-next only. :-)

> The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> the policy notifiers aren't completely removed.

That's not entirely accurate, because arch_topology is going to use
CPUFREQ_CREATE_POLICY now too.

> Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
>
> This has already gone through build bot for a few days now.

So I'd prefer patches [5-8] to go right after the first one and then
do the cleanups on top of that, as somebody may want to backport the
essential changes without the cleanups.
