From: Heiko Schocher <hs@denx.de>
Date: Thu, 09 Dec 2010 06:49:45 +0000
Subject: Re: [PATCH 1/2] video, sm501: add OF binding to support SM501
Message-Id: <4D007C09.3040308@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<20101208053635.GB31508@linux-sh.org>
In-Reply-To: <20101208053635.GB31508@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>

Hello Paul,

Paul Mundt wrote:
> On Sat, Dec 04, 2010 at 09:23:47AM +0100, Heiko Schocher wrote:
>> - add binding to OF, compatible name "smi,sm501"
>>
[...]
>>  Documentation/kernel-parameters.txt          |    7 +
>>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>>  drivers/mfd/sm501.c                          |  141 ++++++++------
>>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>>  include/linux/sm501.h                        |    8 +
>>  5 files changed, 299 insertions(+), 151 deletions(-)
>>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
>>
> Given that this is all SM501 dependent, is there some particular reason
> why you neglected to Cc the author or the MFD folks?

Hups, sorry! No, there is no reason, thanks for detecting this.

Hmm.. couldn;t find a MFD maillinglist?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
