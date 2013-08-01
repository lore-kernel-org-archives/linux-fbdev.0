From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 01 Aug 2013 14:06:50 +0000
Subject: Re: [PATCH v2 00/24] video/da8xx-fb fbdev driver enhance to support TI am335x SoC
Message-Id: <20130801140650.GC27598@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-1-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Wed [2013-Jul-31 13:04:33 +0300]:
> Hi,
> 
> On 30/07/13 21:26, Darren Etheridge wrote:
> > Changes in v2:
> > Addressing review comments from Tomi Valkeinen:
> > 	Dropped readl/writel patch
> > 	Many cosmetic changes to make code easier to understand
> > 
> > 
> > This is primarily a resend of a series of patches that were original
> > submitted to linux-fbdev back in January of 2013 for 3.8 by Afzal
> > Mohammed. I have rebased them on 3.10 and also made sure they
> > apply cleanly to the 'for-next' branch of linux-fbdev git.
> > The patches enable use of the current mainline da8xx-fb driver on the
> > TI AM335x SOC along with some bug fixes and cleanup.
> > 
> > The original patch series can be found here:
> > https://patchwork.kernel.org/project/linux-fbdev/list/?submitter9101
> > if you want to see the history.
> 
> Comments on the whole series:
> 
> Most of the patches are originally from Afzal. I believe some of the
> patches are unchanged, but some are changed by you. In cases like this
> you should pick one of the following options for each patch:
> 
> - If the patch is unchanged, send the patch as it is, having From: Afzal
> line there.
> 
> - If you have changed the patch, send the patch having From: Afzal line,
> but marking in the description that you've changed it (and what you
> did). This should be done if the changes are small.
> 
> - If you changed a lot in the patch, send the patch with yourself as the
> author, signed off by only you, but mention that it's based on Afzal's work.
> The point here is that if you change the patch, it's no longer Afzal's
> original patch. Afzal hasn't reviewed it, so signed-off-by Afzal is not
> correct. You could've introduced horrible bugs in the patch, and I'm
> sure Afzal doesn't want to see that a patch in the kernel introducing
> horrible bugs is from him (when it is not from him).
Understood, and I have made the changes accordingly in the updated
series I am preparing. 

> Another thing are the DT related patches. They should be sent to
> devicetree@vger.kernel.org for review. And I think the DT patches should
> be squashed into one, as they are quite short and having them as a whole
> makes it easier to look at them. You could probably move the DT patches
> to a separate series, so that we can merge the rest of the improvements,
> and manage DT separately.
This is no problem to do, I have extracted the DT patches from the
series and will submit them separately and include the devicetree list.

Thanks for taking the time to review so thoroughly.

Darren

