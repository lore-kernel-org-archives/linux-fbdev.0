From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 23 Jul 2019 06:26:00 +0000
Subject: [PATCH V2 00/10] cpufreq: Migrate users of policy notifiers to QoS requests
Message-Id: <cover.1563862014.git.viresh.kumar@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Erik Schmauss <erik.schmauss@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Javi Merino <javi.merino@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devel@acpica.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello,

Now that cpufreq core supports taking QoS requests for min/max cpu
frequencies, lets migrate rest of the users to using them instead of the
policy notifiers.

The CPUFREQ_NOTIFY and CPUFREQ_ADJUST events of the policy notifiers are
removed as a result, but we have to add CPUFREQ_CREATE_POLICY and
CPUFREQ_REMOVE_POLICY events to it for the acpi stuff specifically,
though they are also used by arch_topology stuff now. So the policy
notifiers aren't completely removed.

Boot tested on my x86 PC and ARM hikey board.

This has already gone through build bot for a few days now.

V1->V2:
- Added Acked-by tags
- Reordered to keep cleanups at the bottom
- Rebased over 5.3-rc1

--
viresh

Viresh Kumar (10):
  cpufreq: Add policy create/remove notifiers
  thermal: cpu_cooling: Switch to QoS requests instead of cpufreq
    notifier
  powerpc: macintosh: Switch to QoS requests instead of cpufreq notifier
  cpufreq: powerpc_cbe: Switch to QoS requests instead of cpufreq
    notifier
  ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
  arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
  video: sa1100fb: Remove cpufreq policy notifier
  video: pxafb: Remove cpufreq policy notifier
  cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier
    events
  Documentation: cpufreq: Update policy notifier documentation

 Documentation/cpu-freq/core.txt            |  16 +--
 drivers/acpi/processor_driver.c            |  44 ++++++++-
 drivers/acpi/processor_perflib.c           | 106 +++++++++-----------
 drivers/acpi/processor_thermal.c           |  81 ++++++++-------
 drivers/base/arch_topology.c               |   2 +-
 drivers/cpufreq/cpufreq.c                  |  51 ++++------
 drivers/cpufreq/ppc_cbe_cpufreq.c          |  19 +++-
 drivers/cpufreq/ppc_cbe_cpufreq.h          |   8 ++
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |  96 +++++++++++-------
 drivers/macintosh/windfarm_cpufreq_clamp.c |  77 ++++++++++-----
 drivers/thermal/cpu_cooling.c              | 110 +++++----------------
 drivers/video/fbdev/pxafb.c                |  21 ----
 drivers/video/fbdev/pxafb.h                |   1 -
 drivers/video/fbdev/sa1100fb.c             |  27 -----
 drivers/video/fbdev/sa1100fb.h             |   1 -
 include/acpi/processor.h                   |  22 +++--
 include/linux/cpufreq.h                    |   4 +-
 17 files changed, 327 insertions(+), 359 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b
