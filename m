From: Tejun Heo <tj@kernel.org>
Date: Sat, 02 Jul 2016 11:35:14 +0000
Subject: Re: [PATCH] omapfb: panel-dsi-cm: Remove deprecated create_singlethread_workqueue
Message-Id: <20160702113514.GE17431@htj.duckdns.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160702082540.GA26570@Karyakshetra>
In-Reply-To: <20160702082540.GA26570@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Jul 02, 2016 at 06:32:31AM -0500, Tejun Heo wrote:
> On Sat, Jul 02, 2016 at 01:55:40PM +0530, Bhaktipriya Shridhar wrote:
> > The workqueue "workqueue" has only a single workitem(&ddata->ulps_work)
> > and hence doesn't require ordering. Also, it is not being used on a
> > memory reclaim path. Hence, the singlethreaded workqueue has been
> > replaced with the use of system_wq.
> > 
> > System workqueues have been able to handle high level of concurrency
> > for a long time now and hence it's not required to have a singlethreaded
> > workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> > created with create_singlethread_workqueue(), system_wq allows multiple
> > work items to overlap executions even on the same CPU; however, a
> > per-cpu workqueue doesn't have any CPU locality or global ordering
> > guarantee unless the target CPU is explicitly specified and thus the
> > increase of local concurrency shouldn't make any difference.
> > 
> > dsicm_remove() calls dsicm_cancel_ulps_work which uses
> > cancel_delayed_work() to ensure that there are no pending tasks while
> > disconnecting the driver.
> > 
> > Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> 
> Looks good.  Thanks.

Heh, should have been

 Acked-by: Tejun Heo <tj@kernel.org>

Sorry about that.  Thanks.

-- 
tejun
