Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C142122C;
	Fri, 31 Jul 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495176; cv=none; b=BEhZAA69fjXHNLfAydOQmQ77tcOWZDwrD98UHWfL8qjnso09diCFOqLUFvsb6rxhuGdVr0S39yadhyQIQN7UjeeRKjb8+/ApfhoWNJOp1UihDFvfzjWs8fMfXBDbuv1kj244IEsKFpmp/a8I1K1nP6Oe3V0ZaiwkI5U5Z6PlKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495176; c=relaxed/simple;
	bh=HmmTU0G8Zq6gkDoVpWYcFIPeZuyHk8l9dsSTIwqOyFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FGW4T8tZAdHmncdTcOCsSqY6ULPZNSBJ7k8fadX1A+JUkkk0JDE7B+S4EDtHvfv4o6dcFyPbYAStj5WYnczyMpunRFkF2nfBz/y716ee/41k03F602ebCDnV51Jai2Ua5N3HdbD9GjpGN20qEg45wBrLf9DESDcByjqrw3P1NWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=rULPH7zn; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="rULPH7zn"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 6ECE28D53AD;
	Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id xeUqlHFTY-a3; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 361278D53B1;
	Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 361278D53B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785494793;
	bh=ucDX/yN/bgjQ8eR0W+6x3z0eH/umeWeTO6jHUIXSMlg=;
	h=From:Date:Message-Id:MIME-Version:To;
	b=rULPH7znXxtYdUGCtyyXimK08iELqDDg2QzjwGCjf6sKnmGmTgmCETypxrzBSHudr
	 EcC7Y9VNZt5DRh1sl5bZ+SBA6SNHQTOUscOFrooxdKT7Y7CjOAClYD0VXSBZugwDtU
	 Yl5aiYGhFpLcyiWxdd8cfWTuYFbz/oA0tpTqN9ZzfT8A0dwtwy4f5GhCUyhShmacqI
	 xe8zVd6s2mxpF48b6Ex4YEu4Jtt4yL2jmfPdpCF3bKaZWhc5pdQzREids5pd0gIEzn
	 NP5tcN5rtejCxa+EzVoiBqf0rR+zOz7qvLb/nq1nupp4TT0FpyJsBI1HOAO06sFJ7d
	 OSRSAzXg2YgOw==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id vZUgiRqc2BKT; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id EAD058D53AD;
	Fri, 31 Jul 2026 12:46:32 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Subject: [PATCH 0/2] fbdev: ssd1307fb: add SH1107 support
Date: Fri, 31 Jul 2026 12:46:15 +0200
Message-Id: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPd8bGoC/yXMQQ5AMBBA0avIrDVpCcVVxIJ2ylggnRKJuLti+
 Rb/X8DoCRma5AKPBzGtS4RKEzBTv4woyEZDJrNS6lwJh30QPCkltTC6dNpWts5tAbHYPDo6v1v
 b/eZ9mNGEdwH3/QCePyXvbwAAAA==
X-Change-ID: 20260731-feat-sh1107-c76f7d8d93d5
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2

This series adds support for the Sino Wealth SH1107 OLED controller
to the ssd1307fb driver.

Patch 1 implements SH1107 support in the ssd1307 driver.
Patch 2 adds the device tree compatible string.

Tested on:
- imx7d-colibri

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
---
Jakub Turek (2):
      fbdev: ssd1307fb: add support for Sino Wealth SH1107 controller
      dt-bindings: display: solomon,ssd1307fb: add SH1107 compatible

 .../bindings/display/solomon,ssd1307fb.yaml        |  17 ++
 drivers/video/fbdev/ssd1307fb.c                    | 234 ++++++++++++++-------
 2 files changed, 172 insertions(+), 79 deletions(-)
---
base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
change-id: 20260731-feat-sh1107-c76f7d8d93d5

Best regards,
--  
Jakub Turek <jakub.turek@elsta.tech>

