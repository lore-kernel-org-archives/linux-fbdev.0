From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 20 Mar 2011 09:22:15 +0000
Subject: Re: [PATCH 09/20] video: msm: Split out MDP2.2 HW specific code.
Message-Id: <20110320092215.GA16646@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300484846-26393-1-git-send-email-carlv@codeaurora.org>
	<1300485423-27281-1-git-send-email-carlv@codeaurora.org>
In-Reply-To: <1300485423-27281-1-git-send-email-carlv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 18, 2011 at 02:57:03PM -0700, Carl Vanderlip wrote:
> +int mdp_ppp_cfg_edge_cond(struct mdp_blit_req *req, struct ppp_regs *regs)
> +{
> +	int32_t luma_interp[4];
> +	int32_t luma_repeat[4];
> +	int32_t chroma_interp[4];
> +	int32_t chroma_bound[4];
> +	int32_t chroma_repeat[4];
> +	uint32_t dst_w, dst_h;
> +
> +	memset(&luma_interp, 0, sizeof(int32_t) * 4);
> +	memset(&luma_repeat, 0, sizeof(int32_t) * 4);
> +	memset(&chroma_interp, 0, sizeof(int32_t) * 4);
> +	memset(&chroma_bound, 0, sizeof(int32_t) * 4);
> +	memset(&chroma_repeat, 0, sizeof(int32_t) * 4);
> +	regs->edge = 0;
> +
> +	if (req->flags & MDP_ROT_90) {
> +		dst_w = req->dst_rect.h;
> +		dst_h = req->dst_rect.w;
> +	} else {
> +		dst_w = req->dst_rect.w;
> +		dst_h = req->dst_rect.h;
> +	}
> +
> +	if (regs->op & (PPP_OP_SCALE_Y_ON | PPP_OP_SCALE_X_ON)) {
> +		get_edge_info(req->src_rect.h, req->src_rect.y, dst_h,
> +			      &luma_interp[IMG_TOP], &luma_interp[IMG_BOTTOM],
> +			      &luma_repeat[IMG_TOP], &luma_repeat[IMG_BOTTOM]);
> +		get_edge_info(req->src_rect.w, req->src_rect.x, dst_w,
> +			      &luma_interp[IMG_LEFT], &luma_interp[IMG_RIGHT],
> +			      &luma_repeat[IMG_LEFT], &luma_repeat[IMG_RIGHT]);
> +	} else {
> +		luma_interp[IMG_LEFT] = req->src_rect.x;
> +		luma_interp[IMG_RIGHT] = req->src_rect.x + req->src_rect.w - 1;
> +		luma_interp[IMG_TOP] = req->src_rect.y;
> +		luma_interp[IMG_BOTTOM] = req->src_rect.y + req->src_rect.h - 1;
> +		luma_repeat[IMG_LEFT] = 0;
> +		luma_repeat[IMG_TOP] = 0;
> +		luma_repeat[IMG_RIGHT] = 0;
> +		luma_repeat[IMG_BOTTOM] = 0;
> +	}
> +
> +	chroma_interp[IMG_LEFT] = luma_interp[IMG_LEFT];
> +	chroma_interp[IMG_RIGHT] = luma_interp[IMG_RIGHT];
> +	chroma_interp[IMG_TOP] = luma_interp[IMG_TOP];
> +	chroma_interp[IMG_BOTTOM] = luma_interp[IMG_BOTTOM];
> +
> +	chroma_bound[IMG_LEFT] = req->src_rect.x;
> +	chroma_bound[IMG_RIGHT] = req->src_rect.x + req->src_rect.w - 1;
> +	chroma_bound[IMG_TOP] = req->src_rect.y;
> +	chroma_bound[IMG_BOTTOM] = req->src_rect.y + req->src_rect.h - 1;
> +
> +	if (IS_YCRCB(req->src.format)) {
> +		chroma_interp[IMG_LEFT] = chroma_interp[IMG_LEFT] >> 1;
> +		chroma_interp[IMG_RIGHT] = (chroma_interp[IMG_RIGHT] + 1) >> 1;
> +
> +		chroma_bound[IMG_LEFT] = chroma_bound[IMG_LEFT] >> 1;
> +		chroma_bound[IMG_RIGHT] = chroma_bound[IMG_RIGHT] >> 1;
> +	}
> +
> +	if (req->src.format = MDP_Y_CBCR_H2V2 ||
> +	    req->src.format = MDP_Y_CRCB_H2V2) {
> +		chroma_interp[IMG_TOP] = (chroma_interp[IMG_TOP] - 1) >> 1;
> +		chroma_interp[IMG_BOTTOM] = (chroma_interp[IMG_BOTTOM] + 1)
> +					    >> 1;
> +		chroma_bound[IMG_TOP] = (chroma_bound[IMG_TOP] + 1) >> 1;
> +		chroma_bound[IMG_BOTTOM] = chroma_bound[IMG_BOTTOM] >> 1;
> +	}
> +
> +	chroma_repeat[IMG_LEFT] = chroma_bound[IMG_LEFT] -
> +				  chroma_interp[IMG_LEFT];
> +	chroma_repeat[IMG_RIGHT] = chroma_interp[IMG_RIGHT] -
> +				  chroma_bound[IMG_RIGHT];
> +	chroma_repeat[IMG_TOP] = chroma_bound[IMG_TOP] -
> +				  chroma_interp[IMG_TOP];
> +	chroma_repeat[IMG_BOTTOM] = chroma_interp[IMG_BOTTOM] -
> +				  chroma_bound[IMG_BOTTOM];
> +
> +	if (chroma_repeat[IMG_LEFT] < 0 || chroma_repeat[IMG_LEFT] > 3 ||
> +	    chroma_repeat[IMG_RIGHT] < 0 || chroma_repeat[IMG_RIGHT] > 3 ||
> +	    chroma_repeat[IMG_TOP] < 0 || chroma_repeat[IMG_TOP] > 3 ||
> +	    chroma_repeat[IMG_BOTTOM] < 0 || chroma_repeat[IMG_BOTTOM] > 3 ||
> +	    luma_repeat[IMG_LEFT] < 0 || luma_repeat[IMG_LEFT] > 3 ||
> +	    luma_repeat[IMG_RIGHT] < 0 || luma_repeat[IMG_RIGHT] > 3 ||
> +	    luma_repeat[IMG_TOP] < 0 || luma_repeat[IMG_TOP] > 3 ||
> +	    luma_repeat[IMG_BOTTOM] < 0 || luma_repeat[IMG_BOTTOM] > 3)
> +		return -1;

Lazy programming strikes again.  Public functions really should not
return things that look like errno codes, rather they should return
real errno codes.

Secondly, why is this stuff, which looks very driver like, under arch/arm
and not in drivers/ somewhere?
