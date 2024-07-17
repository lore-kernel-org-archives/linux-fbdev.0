Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4783BBF7
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206927; cv=none; b=Y6pkUPypkqBzCyznAQMrEqKM1QhLCoLNbBFpCsd6La+LW1T+mXPQ97qYJVUNfEepvV3L4s9beWLPH/wMi8KsBbNTOymiByUY6VhqI1lejsLDui5evemJXBSiC1WrvVA1LK+gx/dqXtpcQ248fhX9SH/zpDYVomYF36GNSfU5HFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206927; c=relaxed/simple;
	bh=2/iSQxDuuZvpcbDb284y6zAsfOC1+tJkVR0628zbgWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZs5UF2KY224BEaS2y3ITun2iAMzQOfv69nwlxx/jcVkQDZg/pNz3n+9G0Cs+9nImAenlrszLQuxMEAtbSusSzLwv0gJq5RlyWH9kmxiDp8K4WqghhLevb3xPdu2rY0Au5etTAxEJ51W3j/sY70UZU7jjwMoYbXcPITumzQ223c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKq2AgCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKq2AgCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721206925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVfoZPm4V6TXucNzTnDE8mLk5shM2EgWGkd75vWlkjU=;
	b=MKq2AgCD36+itLXDaQv4PbOhltgP6X22eO7zv5LKbLYhDWnmi9lzhl+I2XpBcp3RwqxsKu
	FG39oVN/nWQorFE7T+iPnP2Yfv4vr98tRvMacvcbNpIvnxq+GeSvzzTkLTBTgvRzuJQz7b
	PTv5MxV5yuDLk3ZjI7hGXM6rHW2VclM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-axAEi_4uPaC0AwQw8inVnw-1; Wed,
 17 Jul 2024 05:01:59 -0400
X-MC-Unique: axAEi_4uPaC0AwQw8inVnw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97A181955D4B;
	Wed, 17 Jul 2024 09:01:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B8681955F3B;
	Wed, 17 Jul 2024 09:01:53 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 3/3] drm/panic: Remove build time dependency with FRAMEBUFFER_CONSOLE
Date: Wed, 17 Jul 2024 10:48:41 +0200
Message-ID: <20240717090102.968152-4-jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now that fbcon has the skip_panic option, there is no more conflicts
between drm_panic and fbcon.
Remove the build time dependency, so they can be both enabled.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6dd0016fc9cd..a22cab218004 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -107,7 +107,7 @@ config DRM_KMS_HELPER
 
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
-	depends on DRM && !(FRAMEBUFFER_CONSOLE && VT_CONSOLE)
+	depends on DRM
 	select FONT_SUPPORT
 	help
 	  Enable a drm panic handler, which will display a user-friendly message
-- 
2.45.2

