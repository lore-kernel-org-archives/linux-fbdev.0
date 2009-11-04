From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/video/msm: update to new kernel
Date: Tue, 3 Nov 2009 16:17:33 -0800
Message-ID: <20091103161733.970b885f.akpm@linux-foundation.org>
References: <20091022085639.GA30548@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091022085639.GA30548@elf.ucw.cz>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Swetland <swetland@google.com>, Arve Hj?nnev?g <arve@android.com>, linux-fbdev-devel@lists.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, 22 Oct 2009 10:56:39 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> TASK_INTERRUPTIBLE and friends are now only available after including
> <linux/sched.h>, so include it when needed.
> 
> bus_id is no longer available/neccessary, so remove that.
> 
> Android pmem driver is not available in mainline, so remove its hooks
> from drivers/video.
> 

What is the impact of these changes?

#2 looks like it's a build fix.  #3 looks like it isn't a build fix. 
#1 is a mystery.
