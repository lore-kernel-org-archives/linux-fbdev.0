From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jul 2019 10:27:46 +0000
Subject: Re: [PATCH 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Message-Id: <CAJZ5v0jZfmXN=juHX11vmSFj=vxS2Mu_b-OZprB9S+3LJjDb+g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1563269894.git.viresh.kumar@linaro.org>
 <CAJZ5v0iqYHNt6NQy3Fi1B=XtjNOm2x0mX3+7eWBREgFZRpUS+w@mail.gmail.com>
 <20190716101416.ntk353cfnrcykoek@vireshk-i7>
In-Reply-To: <20190716101416.ntk353cfnrcykoek@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Vincent Guittot <vincent.guittot@linaro.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>L

On Tue, Jul 16, 2019 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-07-19, 12:06, Rafael J. Wysocki wrote:
> > On Tue, Jul 16, 2019 at 11:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Hello,
> > >
> > > Now that cpufreq core supports taking QoS requests for min/max cpu
> > > frequencies, lets migrate rest of the users to using them instead of the
> > > policy notifiers.
> >
> > Technically, this still is linux-next only. :-)
>
> True :)
>
> > > The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
> > > removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
> > > CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically. So
> > > the policy notifiers aren't completely removed.
> >
> > That's not entirely accurate, because arch_topology is going to use
> > CPUFREQ_CREATE_POLICY now too.
>
> Yeah, I thought about that while writing this patchset and
> coverletter. But had it not been required for ACPI, I would have done
> it differently for the arch-topology code. Maybe direct calling of
> arch-topology routine from cpufreq core. I wanted to get rid of the
> policy notifiers completely but I couldn't find a better way of doing
> it for ACPI stuff.
>
> > > Boot tested on my x86 PC and ARM hikey board. Nothing looked broken :)
> > >
> > > This has already gone through build bot for a few days now.
> >
> > So I'd prefer patches [5-8] to go right after the first one and then
> > do the cleanups on top of that, as somebody may want to backport the
> > essential changes without the cleanups.
>
> In the exceptional case where nobody finds anything wrong with the
> patches (highly unlikely), do you want me to resend with reordering or
> you can reorder them while applying? There are no dependencies between
> those patches anyway.

Please resend the reordered set when the merge window closes.
