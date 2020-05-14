From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Thu, 14 May 2020 11:19:23 +0000
Subject: Re: [PATCH v12 00/14] In order to readout DP SDPs, refactors the handling of DP SDPs
Message-Id: <87eerm4vd0.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200514060732.3378396-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200514060732.3378396-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>, intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch

On Thu, 14 May 2020, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:
> In order to readout DP SDPs (Secondary Data Packet: DP HDR Metadata
> Infoframe SDP, DP VSC SDP), it refactors handling DP SDPs codes.
> It adds new compute routines for DP HDR Metadata Infoframe SDP
> and DP VSC SDP. 
> And new writing routines of DP SDPs (Secondary Data Packet) that uses
> computed configs.
> New reading routines of DP SDPs are added for readout.
> It adds a logging function for DP VSC SDP.
> When receiving video it is very useful to be able to log DP VSC SDP.
> This greatly simplifies debugging.
> In order to use a common VSC SDP Colorimetry calculating code on PSR,
> it uses a new psr vsc sdp compute routine.

Pushed the series to drm-intel-next-queued with Daniel's irc ack for
merging the two non-i915 patches that route too.

Thanks for the patches and review!

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
