From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 12 Nov 2013 10:37:51 +0000
Subject: Re: [PATCH 1/5] arm: sa1100: add cpu clock
Message-Id: <528204FF.8010503@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
 <20131112095706.GE16735@n2100.arm.linux.org.uk>
In-Reply-To: <20131112095706.GE16735@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/12/2013 01:57 PM, Russell King - ARM Linux wrote:
> On Tue, Nov 12, 2013 at 07:32:08AM +0400, Dmitry Eremin-Solenikov wrote:
>> Both SA1100 framebuffer and PCMCIA drivers require knowledge of cpu
>> frequency to correctly program timings.  Currently they receive timing
>> information by calling cpufreq_get(0).  However if cpu frequency driver
>> is not enabled (e.g. due to unsupported DRAM chip/board on sa1110)
>> cpufreq_get(0) returns 0, causing incorrect timings to be programmed.
>
> I added a select statement back in 1937f5b91833e2e8e53bcc821fc7a5fbe6ccb9b5
> which avoids this problem.  Does this not work?

No, it does not.

1) For collie (sa1110) we don't have dram chip timings in table, so the 
cpufreq driver is not registered and cpufreq_get() returns 0

2) What if I want to build a kernel w/o cpu freq? We have clocks exactly 
for this reasons - to let drivers get frequency information.

3) And last but not least - PXA uses clocks in this place.


-- 
With best wishes
Dmitry
