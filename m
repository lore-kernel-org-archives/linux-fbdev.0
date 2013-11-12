From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 12 Nov 2013 09:57:06 +0000
Subject: Re: [PATCH 1/5] arm: sa1100: add cpu clock
Message-Id: <20131112095706.GE16735@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1384227132-10501-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Nov 12, 2013 at 07:32:08AM +0400, Dmitry Eremin-Solenikov wrote:
> Both SA1100 framebuffer and PCMCIA drivers require knowledge of cpu
> frequency to correctly program timings.  Currently they receive timing
> information by calling cpufreq_get(0).  However if cpu frequency driver
> is not enabled (e.g. due to unsupported DRAM chip/board on sa1110)
> cpufreq_get(0) returns 0, causing incorrect timings to be programmed.

I added a select statement back in 1937f5b91833e2e8e53bcc821fc7a5fbe6ccb9b5
which avoids this problem.  Does this not work?
