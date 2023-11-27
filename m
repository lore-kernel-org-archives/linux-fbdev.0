Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD353033F;
	Mon, 27 Nov 2023 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxS9hJoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCFAC433C9;
	Mon, 27 Nov 2023 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701093251;
	bh=HndP7kMXn51lK3Jva+NBlGfD5QReY9K9C8oB1c8J5F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxS9hJoPFPRbEyqh+oWQyk0yNzXtrRvykVN1klQqYitHYieP7b673yHpCfzMUNgQG
	 IbEx0KSA0SoSHl5Q43WfL78AZ8f4Q0kPnvmXLv4Jrm5crXkFlLSlcB53klG6zuvURS
	 ZEecMvXhzfqBdCdyaTnGZdEXS0fm/DE1IhRyN8P0=
Date: Mon, 27 Nov 2023 13:29:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 25/32] staging/sm750fb: Declare fb_ops as constant
Message-ID: <2023112750-ditzy-scrutiny-f105@gregkh>
References: <20231127131655.4020-1-tzimmermann@suse.de>
 <20231127131655.4020-26-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127131655.4020-26-tzimmermann@suse.de>

On Mon, Nov 27, 2023 at 02:15:54PM +0100, Thomas Zimmermann wrote:
> Split up lynxfb_ops and declare each as constant. The fb_ops
> instance used to be modified while initializing the driver. It is
> now constant and the driver picks the correct instance, depending
> on the settings for acceleration and cursor support.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 59 +++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 10 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
