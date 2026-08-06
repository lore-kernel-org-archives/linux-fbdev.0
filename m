Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC05479872;
	Thu,  6 Aug 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.20.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048005; cv=none; b=i6AkdDXdafduGzkWPBKXSyCz5WWKMkFxcuyitbInXv/+U1Z/uYMde/ia2cPUUY5U2Mozq1HswZYlrrsPQeZejwQHhC4aPGkpA0FoaO8TVFVBqOswujsnkeQWdtuxX3caS3H+dMrGQQpPn5gYSJ7VFczZpUkxJ2tnLgEPCdLfTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048005; c=relaxed/simple;
	bh=F1A/QHz5hbGeDMZiRvNopgtKoOjegOK3cdF/c05Q/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvjF6tYdai7fA+/l5Br6wrt68rZ1PHGdcPVl5ToooToK6e5bbVkRN+cEXlkQe0fYHeMKcBNbBebCePiBlVzo44sP9PFyhrNepYyGAQjB2fFRw1sKp0hmqkt18nx3uuYGlJFrnUWmEWPMNduQOeN5QATgSdo+iWjxRMQA7iqgfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io; spf=pass smtp.mailfrom=dewith.io; dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b=OYP2+wss; arc=none smtp.client-ip=157.90.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dewith.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dewith.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dewith.io header.i=@dewith.io header.b="OYP2+wss"
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by meve.dewith.io (Postfix) with ESMTPSA id 402B223D90;
	Thu,  6 Aug 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default;
	t=1786047591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1dLP/FEQKxT40U9k4SifBNc/F8DQLWHwpEry3VU43g=;
	b=OYP2+wsszoD4nkj5o+EnNtlwsJovLvNEJdG4ICx50cUdAh00lLG2ew3smBWEgvC3VeIEG5
	pu6WhLKFda5RrTTpAWFgcxN1IAzXRDpvfjLlw6Envy2yvLZBVZZG2C+tVL5v0DNpxwb2OL
	oHzMIv04SgiYTQi0i3glVL+qFT8kRwU=
From: Wim de With <wf@dewith.io>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: Wim de With <wf@dewith.io>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] backlight: Add support for Orient Chip OCP8178
Date: Thu,  6 Aug 2026 22:15:39 +0200
Message-ID: <20260806201541.101304-1-wf@dewith.io>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ClockworkPi uConsole[1] is a modular handheld console manufactured
by Clockwork Tech that runs Linux. It consists of a mainboard which
connects a number of peripherals, such as the screen, batteries and
keyboard. This mainboard hosts a system on a module (SoM), such as the
Raspberry Pi Compute Module as a so-called core to provide the compute
for the device. The device supports different kinds of SoM as cores. The
mainboard is shared between different devices, such as the DevTerm[2].

Currently, the uConsole requires a number of out-of-tree drivers to
support the hardware. In addition, most (if not all) supported SoMs
require vendor kernels. In practice, this means that kernel support for
the device is scattered across various repositories in the form of
patches with dubious quality.

This patch series is the first in an attempt to upstream as many of the
needed drivers as possible. The goal is to support at least the
mainboard and the peripherals of the uConsole in the upstream kernel.
These drivers should find their way downstream to the SoM vendor kernels
eventually.

This series adds the driver for the backlight controller, the Orient
Chip OCP8178. I wrote the driver from scratch using the datasheet, to
avoid any copyright or attribution problems.

[1]: https://www.clockworkpi.com/home-uconsole
[2]: https://www.clockworkpi.com/home-devterm

Wim de With (2):
  dt-bindings: backlight: Add Orient Chip OCP8178 bindings
  backlight: Add support for Orient Chip OCP8178

 .../bindings/leds/backlight/ocs,ocp8178.yaml  |  46 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |  10 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/ocp8178_bl.c          | 243 ++++++++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
 create mode 100644 drivers/video/backlight/ocp8178_bl.c

-- 
2.55.0

