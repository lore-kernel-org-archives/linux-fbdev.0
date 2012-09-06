From: Archit Taneja <a0393947@ti.com>
Date: Thu, 06 Sep 2012 13:47:38 +0000
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Message-Id: <5048A6AA.50009@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>  <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>  <50475444.2080509@ti.com> <1346936681.2737.61.camel@deskari>
In-Reply-To: <1346936681.2737.61.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 06 September 2012 06:34 PM, Tomi Valkeinen wrote:
> On Wed, 2012-09-05 at 19:01 +0530, Archit Taneja wrote:
>> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
>>> Now that fifo merge has been removed, nobody uses the extra_info related
>>> completion code, which can be removed.
>>
>> I think this might come into use when we fix the usage of channel out
>> field. That is, since channel out is an immediate write field, when we
>> set a new manager for an overlay, we may need to wait till the overlay
>> disable kicks in, only then we should change channel out.
>>
>> For this, we would need some wait for extra_info, right?
>
> Hmm, yes, I think you are right. Previously the ovl_disable waited until
> the overlay is not used anymore, but now it doesn't.
>
> So I think I need to add wait_pending_extra_info_updates() call to the
> beginning of dss_ovl_set_manager(). Or, should it be in unset_manager...
> I think unset is better, then a "free" overlay always disabled also in
> the HW level.

Yes, I also think it should be in unset_manager. One option could be to 
leave the wait_pending_extra_info_updates() in ovl_disable itself, as it 
was before. But that would force us to use mutexes there, and we'd 
rather have overlay enabling and disabling as a non blocking thing.

Archit

